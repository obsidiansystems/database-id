database-id-groundhog
---------------------

This package provides support for groundhog database interaction to database-id-class, in particular, the functions

    toId :: DefaultKeyId a => DefaultKey a -> Id a
    fromId :: DefaultKeyId a => Id a -> DefaultKey a

which convert back and forth between the Id and groundhog's DefaultKey representation according to the instances of
the `DefaultKeyId` class.

It also includes the Template Haskell macro `makeDefaultKeyIdInt64` which, given the `Name` of a datatype and the `Name` of
the data constructor for its groundhog-generated key datatype (typically named the same as the type, with the suffix
"Key"), produces an instance of DefaultKeyId in cases where the primary key is an `Int64`.

Similar to this, `makeDefaultKeyIdSimple` exists for cases where all that is required to go between `DefaultKey a` and
`IdData a` is to remove (or put back) Groundhog's type-specific Key data constructor.

It also includes instances of `PersistField` and `PrimitivePersistField` for `Id a`.
