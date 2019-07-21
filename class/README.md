database-id-class
-----------------

This package defines a (parametric) data type `Id a` used to refer to the primary key of values of type `a` in a database.

    newtype Id a = Id { unId :: IdData a }

Here, `IdData` is a type family associated with the `HasId` class:

    class HasId a where
      type IdData a :: *
      type IdData a = Int64

It defaults to `Int64` because that tends to be the type you want for tables with an autoincrement primary key.
