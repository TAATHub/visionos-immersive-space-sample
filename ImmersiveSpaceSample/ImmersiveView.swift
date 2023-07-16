import SwiftUI
import RealityKit
import WorldAssets

struct ImmersiveView: View {
    var body: some View {
        ZStack {
            RealityView { content in
                guard let resource = try? TextureResource.load(named: "Starfield") else {
                    fatalError("Unable to load texture.")
                }
                
                var material = UnlitMaterial()
                material.color = .init(texture: .init(resource))
                
                let entity = Entity()
                entity.components.set(ModelComponent(
                    mesh: .generateSphere(radius: 1000),
                    materials: [material]
                ))
                
                entity.scale *= SIMD3(repeating: -1)
                content.add(entity)
            }
            
            RealityView { content in
                guard let model = try? await ModelEntity(named: "Moon", in: worldAssetsBundle) else {
                    fatalError("Unable to load model.")
                }

                model.scale = SIMD3(repeating: 1)
                model.position = SIMD3(x: 0, y: 0, z: 0)
                content.add(model)
            }
        }
    }
}

#Preview {
    ImmersiveView()
}
