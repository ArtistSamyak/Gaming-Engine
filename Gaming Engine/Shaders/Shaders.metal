//
//  Shaders.metal
//  Gaming Engine
//
//  Created by Samyak Pawar on 02/11/21.
//

#include <metal_stdlib>
using namespace metal;

//we can use "constant" for { get } or "device" for { get set } 
vertex float4 basic_vertex_shader(constant float3 *vertices [[ buffer(0) ]], uint vertexId [[ vertex_id ]]){
    return float4(vertices[vertexId], 1);
}

fragment half4 basic_fragment_shader(){
    return half4(1);
}
