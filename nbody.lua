require "printtable"
JSON = (loadfile "JSON.lua")()

gravitational_constant = 6.67384e-11 -- m^3 kg^-1 s^-2
c = 299792458 -- m/s

function calculate_force(distance, mass_1, mass_2)
    return gravitational_constant * mass_1 * mass_2 / (distance^2)
end

function calculate_acceleration(force, mass)
    return force / mass
end

function calculate_distance(pos_1, pos_2)
    local sum = 0
    for i = 1, #pos_1, 1 do
        sum = sum + (pos_1[i] + pos_2[i])^2
    end
    return math.sqrt(sum)
end

function calculate_magnitude(vec)
    local sum = 0
    for i = 1, #vec, 1 do
        sum = sum + vec[i]^2
    end
    return math.sqrt(sum)
end

function add_vector(vec_1, vec_2)
    local vec = {}
    for i = 1, #vec_1, 1 do
        table.insert(vec, vec_1[i] + vec_2[i])
    end
    return vec
end

function subtract_vector(vec_1, vec_2)
    local vec = {}
    for i = 1, #vec_1, 1 do
        table.insert(vec, vec_1[i] - vec_2[i])
    end
    return vec
end

function scale_vector(vec, scalar)
    local new_vec = {}
    for i = 1, #vec, 1 do
        table.insert(new_vec, vec[i] * scalar)
    end
    return new_vec
end

function create_velocity_vector(from_pos, to_pos, acc)
    local distance = calculate_distance(from_pos, to_pos)
    local unit_vector = scale_vector(subtract_vector(to_pos, from_pos), 1/distance)
    return scale_vector(unit_vector, acc)
end

function calculate_special_relativity_dilation(quantity, vec)
    local velocity = calculate_magnitude(vec)
    return quantity / (1 - velocity^2 / c^2)
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function clone_body(body)
    return {name = body.name, mass = body.mass, rest_mass = body.rest_mass, pos = shallowcopy(body.pos), vector = shallowcopy(body.vector), time = body.time}
end

f = io.open("bodies.json", "r")
content = f:read("*all")
f:close()

bodies = JSON:decode(content)
--ptable(bodies, "Start")

for i, body in ipairs(bodies) do
    body.time = 0
    body.rest_mass = body.mass
end

time_step = arg[1]
time_end = arg[2]
for time = 0, time_end, time_step do
    --print("Time =", time)

    local new_bodies = {}
    for i = 1, #bodies, 1 do
        local body = bodies[i]
        --ptable(body, "Body")
        local new_body = clone_body(body)
        table.insert(new_bodies, new_body)

        for j = 1, #bodies, 1 do
            if i ~= j then
                local other_body = bodies[j]

                local distance = calculate_distance(body.pos, other_body.pos)
                --print("Distance =", distance)

                local force = calculate_force(distance, body.mass, other_body.mass)
                --print("Force =", force)

                local acc = calculate_acceleration(force, body.mass)
                --print("Acceleration =", acc)

                local vel = create_velocity_vector(body.pos, other_body.pos, acc)
                new_body.vector = add_vector(new_body.vector, vel)
            end
        end

        local time_vel = scale_vector(new_body.vector, time_step)
        --ptable(new_body.vector, new_body.name.." velocity")
        new_body.pos = add_vector(new_body.pos, time_vel)

        time_dilation = calculate_special_relativity_dilation(time_step, time_vel)
        new_body.time = new_body.time + time_dilation

        relativistic_mass = calculate_special_relativity_dilation(new_body.rest_mass, time_vel)
        new_body.mass = relativistic_mass
    end

    bodies = new_bodies
    --print()
end

for i, body in ipairs(bodies) do
    ptable(body)
end
