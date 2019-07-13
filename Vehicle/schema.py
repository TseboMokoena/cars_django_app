import graphene

from graphene_django.types import DjangoObjectType

from Vehicle.models import Vehicle, Colour


class VehicleType(DjangoObjectType):
    class Meta:
        model = Vehicle


class ColourType(DjangoObjectType):
    class Meta:
        model = Colour


class Query(object):
    all_vehicles = graphene.List(VehicleType)
    all_colours = graphene.List(ColourType)

    def resolve_all_vehicles(self, info, **kwargs):
        return Vehicle.objects.all()

    def resolve_all_colours(self, info, **kwargs):
        # We can easily optimize query count in the resolve method
        return Colour.objects.select_related('vehicle').all()


# Add New Vehicle Mutation
class AddVehicle(graphene.Mutation):
    class Arguments:
        # The input arguments for this mutation
        vehicleName = graphene.String(required=True)
        vehicleColour = graphene.String(required=True)

    # The class attributes define the response of the mutation
    vehicle = graphene.Field(VehicleType)

    def mutate(self, info, vehicleName, vehicleColour):
        _colour = Colour.objects.get(name=vehicleColour)
        _vehicle = Vehicle.objects.create(name=vehicleName, colour=_colour)

        # Notice we return an instance of this mutation
        return AddVehicle(vehicle=_vehicle)


# Add New Colour Mutation
class AddColour(graphene.Mutation):
    class Arguments:
        colourName = graphene.String(required=True)

    colour = graphene.Field(ColourType)

    def mutate(self, info, colourName):
        _colour = Colour.objects.create(name=colourName)

        return AddColour(colour=_colour)


class Mutation(object):
    add_vehicle = AddVehicle.Field()
    add_colour = AddColour.Field()
