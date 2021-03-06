/*
Copyright(c) 2016 Christopher Joseph Dean Schaefer

This software is provided 'as-is', without any express or implied
warranty.In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions :

1. The origin of this software must not be misrepresented; you must not
claim that you wrote the original software.If you use this software
in a product, an acknowledgment in the product documentation would be
appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
*/

#version 400
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout(push_constant) uniform UniformBufferObject {
    mat4 totalTransformation;
} ubo;

layout (location = 0) in vec4 position;
layout (location = 1) in uvec4 attr1;
layout (location = 2) in vec2 attr2;
layout (location = 0) out vec4 color;
layout (location = 1) out vec2 texcoord;

out gl_PerVertex 
{
        vec4 gl_Position;
};

vec4 Convert(uvec4 rgba)
{
	vec4 unpacked;

	unpacked.w = float(rgba.w);
	unpacked.z = float(rgba.z);
	unpacked.y = float(rgba.y);
	unpacked.x = float(rgba.x);

	unpacked.x = unpacked.x / 255;
	unpacked.y = unpacked.y / 255;
	unpacked.z = unpacked.z / 255;
	unpacked.w = unpacked.w / 255;	

	return unpacked;
}

void main() 
{	
	gl_Position = ubo.totalTransformation * position * vec4(1.0,-1.0,1.0,1.0);

	color = Convert(attr1);
	texcoord = attr2;
}