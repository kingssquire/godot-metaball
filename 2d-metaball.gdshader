shader_type canvas_item;

uniform vec4 albedo_color: source_color ;

void fragment() {
	// Called for every pixel the material is visible on.
	float a = texture(TEXTURE, UV).a;
	vec4 metaball = vec4(1, a > 0.7? 1.0: 0.0, a > 0.8? 1.0: 0.0, a > 0.5? 1.0: 0.0);
	COLOR = albedo_color;
	COLOR.a = metaball.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
