//
//  GameView.swift
//  Gaming Engine
//
//  Created by Samyak Pawar on 02/11/21.
//

import Cocoa
import MetalKit

class GameView: MTKView {
    
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    
    let triangleVertices: [SIMD3<Float>] = [
        SIMD3<Float>(0,1,0),
        SIMD3<Float>(-0.5,-1,0),
        SIMD3<Float>(1,0,0)
    ]
    
    var vertexBuffer: MTLBuffer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        self.clearColor = MTLClearColor(red: 0.8, green: 0.3, blue: 0.4, alpha: 1)
        self.colorPixelFormat = .bgra8Unorm
        
        self.commandQueue = device?.makeCommandQueue()
        
        createRenderPipelineState()
        
        createBuffers()
        
    }
    
    func createBuffers() {
        vertexBuffer = device?.makeBuffer(bytes: triangleVertices, length: MemoryLayout<SIMD3<Float>>.stride * triangleVertices.count, options: [])
    }
    
    func createRenderPipelineState() {
        let library = device?.makeDefaultLibrary()
        
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        do {
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch  {
            debugPrint("Error setting renderPipelineState")
        }
        
        
    }
    
    override func draw() {
        
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()!
        let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
        //add more info to command encoder.
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: triangleVertices.count)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    
}
