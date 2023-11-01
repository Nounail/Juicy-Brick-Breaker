shader_type canvas_item;

uniform float light_radius : hint_range(0.01, 1.0);
uniform vec4 light_color : hint_color;

void fragment() {
    // Calculate the distance from the fragment to the center of the node
    vec2 frag_center = vec2(0.5, 0.5); // Center of the node
    float distance_to_center = distance(frag_center, FRAGCOORD.xy);

    // If the fragment is outside the light radius, it's completely dark
    if (distance_to_center > light_radius) {
        discard;
    } else {
        // Calculate the amount of light based on the distance to the center
        float light_intensity = 1.0 - (distance_to_center / light_radius);

        // Apply the light color
        COLOR = light_color * light_intensity;
    }
}

