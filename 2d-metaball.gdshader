shader_type canvas_item;

uniform vec4 albedo_color: source_color ;
uniform vec4 white_color : source_color = vec4(1.0);
uniform vec4 black_color : source_color = vec4(0.0);

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex = texture(TEXTURE, UV);
	float a = texture(TEXTURE, UV).a;
	vec4 metaball = vec4(1, a > 0.7? 1.0: 0.0, a > 0.8? 1.0: 0.0, a > 0.5? 1.0: 0.0);
	
	if (tex.rgb == white_color.rgb || tex.rgb == black_color.rgb){
		COLOR.rgb = albedo_color.rgb;
		COLOR.a = metaball.a;
	} else {
		COLOR.a = metaball.a;
	};
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
