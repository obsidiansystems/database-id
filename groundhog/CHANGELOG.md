# Revision history for database-id-groundhog

## 0.1.0.1

* Add readme

## 0.1.0.0

* Initial release. Defines the DefaultKeyId class, connecting groundhog IDs to HasId instances, and some convenience functions for going back and forth between the two.
* Add PersistField instances handy for storing `Id`s in the database (e.g., as foreign keys).
* Add Template Haskell for generating IdData and DefaultKeyId instances
