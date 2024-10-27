shader_type spatial;
render_mode unshaded;

uniform float flare : hint_range(0.0, 2.0) = 1.0;
uniform vec2 mouse_position;

uniform float NUM_LAYERS : hint_range(0.0, 10.0) = 4.0;
uniform float overlay_alpha : hint_range(0.0, 1.0) = 0.5; // Overlay transparency control

mat2 Rot(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(vec2(c, -s), vec2(s, c));
}

float Star(vec2 uv, float flare_intensity) {
    float d = length(uv);
    float m = 0.05 / d;
    
    float rays = max(0.0, 1.0 - abs(uv.x * uv.y * 1000.0));
    m += rays * flare_intensity;
    uv *= Rot(3.1415 / 4.0);
    rays = max(0.0, 1.0 - abs(uv.x * uv.y * 1000.0));
    m += rays * 0.3 * flare_intensity;
    
    m *= smoothstep(1.0, 0.2, d);
    return m;
}

float Hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec3 StarLayer(vec2 uv) {
    vec3 col = vec3(0.0);
    vec2 gv = fract(uv) - 0.5;
    vec2 id = floor(uv);
    
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 offs = vec2(float(x), float(y));
            
            float n = Hash21(id + offs);
            float size = fract(n * 345.32);
            
            float star = Star(gv - offs - vec2(n, fract(n * 34.0)) + 0.5, smoothstep(0.9, 1.0, size) * 0.6);
            vec3 color = sin(vec3(0.2, 0.3, 0.9) * fract(n * 2345.2) * 123.2) * 0.5 + 0.5;
            color = color * vec3(1.0, 0.25, 1.0 + size) + vec3(0.2, 0.2, 0.1) * 2.0;
            
            star *= sin(TIME * 3.0 + n * 6.2831) * 0.5 + 1.0;
            col += star * size * color;
        }
    }
    return col;
}

void fragment() {
    vec2 uv = (FRAGCOORD.xy - 0.5 * VIEWPORT_SIZE) / VIEWPORT_SIZE.y;
    vec2 M = (mouse_position - 0.5 * VIEWPORT_SIZE) / VIEWPORT_SIZE.y;
    
    float t = TIME * 0.02;
    uv += M * 4.0;
    uv *= Rot(t);
    
    vec3 col = vec3(0.0);
    
    for (float i = 0.0; i < 1.0; i += 1.0 / NUM_LAYERS) {
        float depth = fract(i + t);
        float scale = mix(20.0, 0.5, depth);
        float fade = depth * smoothstep(1.0, 0.9, depth);
        col += StarLayer(uv * scale + i * 453.2 - M) * fade;
    }
    
    col = pow(col, vec3(0.4545)); // gamma correction
    
    // Blend with black overlay using overlay_alpha
    col = mix(vec3(0.0), col, 1.0 - overlay_alpha);

    ALBEDO = col;
}
