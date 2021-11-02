//
//  Shaders.metal
//  Gaming Engine
//
//  Created by Samyak Pawar on 02/11/21.
//

#include <metal_stdlib>
using namespace metal;

//we can use "constant" for { get } or "device" for { get set } 
//vertex float4 basic_vertex_shader(constant float3 *vertices [[ buffer(0) ]], uint vertexId [[ vertex_id ]]){
//    return float4(vertices[vertexId], 1);
//}

struct VertexIn {
    float3 position;
    float4 color;
};

struct RasterizerData {
    float4 position [[ position ]];
    float4 color;
};

vertex RasterizerData basic_vertex_shader(constant VertexIn *colorTriangleVertices [[ buffer(0) ]], uint vertexId [[ vertex_id ]]) {
    
    RasterizerData rd;
    
    rd.position = float4(colorTriangleVertices[vertexId].position,1.5);
    rd.color = colorTriangleVertices[vertexId].color;
    
    return rd;
    
}

fragment half4 basic_fragment_shader(RasterizerData rda [[ stage_in ]]){
    float4 color = rda.color;
    
    return half4(color.r, color.g, color.b, color.a);
    
}
