### Flags for RosettaMembrane from 2006 (will be deprecated soon)

|**Flag**|**Description**|
|:-------|:--------------|
|-membrane <boolean>|Initialize a pose as a membrane pose|
|-in:file:spanfile <string>|Spanfile containing transmembrane span information, converted from OCTOPUS output|
|-in:file:lipofile <string>|Lipophilicity file containing lipid accessibilities, converted from LIPS output|
|-center_search <bool>|Perform membrane center search, default false|
|-normal search <bool>|Perform membrane normal search, default false|
|-center_mag <real>|Magnitude of membrane normal center search (Angstroms), default 1|
|-center_max_delta <int>|Magnitude of maximum membrane width deviation during membrane center search (Angstroms), default 5|
|-normal_start_angle <int>|magnitude of starting angle during membrane normal search (degrees), default 10|
|-normal_delta_angle <int>|magnitude of angle deviation during membrane normal search (degrees), default 10|
|-normal_cycles <int>|Cycles for finding good embedding normal, default 100|
|-normal_max_angle <int>|magnitude of maximum angle deviation during membrane normal search (degrees), default 40|
|-normal_mag <real>|Magnitude of membrane normal angle search (degrees), default 5|
|-smooth_move_frac <real>|???, default 0.5|
|-no_interpolate_Mpair <boolean>|Don't interpolate between layers for pair interactions, default false|
|-Menv_penalties <bool>|Turn on penalties, default false|
|-Mhbond_depth <bool>|Membrane depth dependent correction to the hbond potential, default false|
|-Membed_init <bool>|??? default false|
|-Fa_Membed_update <bool>|??? default false|
|-fixed_membrane <bool>|Fix membrane position, by default the center is at [0,0,0] and membrane normal is the z-axis, default false|
|-membrane_center <vector of reals>|Membrane center x,y,z|
|-membrane_normal <vector of reals>|Membrane normal x,y,z|
|-thickness <real>|One leaflet hydrocarbon thickness for solvation calculations (Angstroms), default 15|
|-view <bool>|View membrane during protocol, default false|
|-debug <bool>|Print debug output, default false|