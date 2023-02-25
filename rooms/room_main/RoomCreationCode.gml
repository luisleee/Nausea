//Whatever how deep
instance_create_depth(0, 0, 0, file_loader);
instance_create_depth(0, 0, 0, debugger);
instance_create_depth(0, 0, 0, data_recorder);
instance_create_depth(0, 0, 0, chain_storage);
instance_create_depth(0, 0, 0, map_storage);

//non-display components
instance_create_depth(0, 0, 0, music_player);

//display components
instance_create_depth(0, 0, 0, map);
instance_create_depth(0, 0, -10, image_painter);

instance_create_depth(0, 0, -20, textbar);
instance_create_depth(0, 0, -30, options);
instance_create_depth(0, 0, -40, mind);
instance_create_depth(0, 0, -50, task_manager);
instance_create_depth(0, 0, -60, chain_player);
