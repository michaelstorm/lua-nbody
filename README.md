lua-nbody
=========

Toy n-body simulation in Lua with an arbitrary number of spatial dimensions and basic special relativity adjustments.


Usage
-----

`lua nbodies.lua BODIES_FILE_PATH TIME_STEP TIME_END`

`BODIES_FILE_PATH` is a path to a JSON file describing the starting state of the bodies to be simulated. See section below.

`TIME_STEP` is a floating-point value expressing the seconds between samples. Lower is more precise, but slower to compute.

`TIME_END` is the number of seconds at which to terminate the simulation.


Example
-------

    $ lua nbody.lua bodies.json .1 10000
    {
      mass = 5.972e+24,
      pos = {
        [1] = 15929.242339019,
        [2] = 0,
        [3] = 138.58009194716,
      }
      vector = {
        [1] = 3.1886978322112,
        [2] = 0,
        [3] = 0.041637309060105,
      }
      time = 10000.000000019,
      name = 'Earth',
      rest_mass = 5.972e+24,
    }
    {
      mass = 7.3476730900009e+22,
      pos = {
        [1] = 391213312.08884,
        [2] = 0,
        [3] = 10218736.565999,
      }
      vector = {
        [1] = -259.16917125614,
        [2] = 0,
        [3] = 1019.6158264438,
      }
      time = 10000.000000019,
      name = 'Moon',
      rest_mass = 7.34767309e+22,
    }


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
