shader_type canvas_item;

uniform float curve_strength : hint_range(-0.1, 0.1) = 0.03;  // How much it bends (positive = opens outward)
uniform float center_x : hint_range(0.0, 1.0) = 0.5;         // Where the spine is (0.5 = center)

void fragment() {
    vec2 uv = UV;
    
    // Create a gentle parabolic curve (like a slightly open book page)
    float bend = (uv.x - center_x) * (uv.x - center_x);
    uv.y += bend * curve_strength * (uv.x - center_x > 0.0 ? 1.0 : -1.0);  // Adjust direction per side
    
    // Optional: add a tiny horizontal stretch near the spine for more realism
    uv.x += (uv.x - center_x) * bend * 0.08;
    
    COLOR = texture(TEXTURE, uv);
    
    // Optional: fade edges slightly for better blending
    COLOR.a *= smoothstep(0.0, 0.05, uv.y) * smoothstep(1.0, 0.95, uv.y);
}