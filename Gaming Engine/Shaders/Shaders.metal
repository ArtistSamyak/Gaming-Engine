//
//  Shaders.metal
//  Gaming Engine
//
//  Created by Samyak Pawar on 02/11/21.
//

#include <metal_stdlib>
using namespace metal;

vertex float4 basic_vertex_shader(){
    return float4(1);
}

fragment half4 basic_fragment_shader(){
    return half4(1);
}
