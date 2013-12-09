lua-nbody
=========

Toy n-body simulation in Lua with an arbitrary number of spatial dimensions and basic special relativity adjustments.

Usage
-----

`lua nbodies.lua TIME_STEP TIME_END`

`TIME_STEP` is a floating-point value expressing the seconds between samples. Lower is more precise, but slower to compute.

`TIME_END` is the number of seconds at which to terminate the simulation.

Body description format
-----------------------

Example of expected JSON:

    [
        {
            "name": "Earth",
            "mass": 5.972e24,
            "pos": [0, 0, 0],
            "vector": [0, 0, 0]
        },
        {
            "name": "Moon",
            "mass": 7.34767309e22,
            "pos": [392508000, 0, 0],
            "vector": [0, 0, 1023]
        }
    ]

Masses are in kilograms. Times are in seconds. Distances are in meters.

Any cardinality of spatial dimensions may be used.

Names are optional. Any number of bodies may be specified.
