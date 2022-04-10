How to save a new abandoned base:

- To create an abandoned base around certain x,y coordinates where a base
  currently exists, use the query in create_abandoned_base_from_coords_<map>.sql
  with coordinates and search radius set by @originx, @originy and @originr.

TODO: Not finished!
- To configure a procedure which does this when called, source the file:
  old_bases_events_hive_<map>.sql
  
