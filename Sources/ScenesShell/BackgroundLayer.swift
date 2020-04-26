import Scenes

/*
 This class is responsible for the background Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class BackgroundLayer : Layer {
    let background = Background()

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")

        // We insert our RenerableEntities in the constructor
        insert(entity:background, at:.back)
    }
}
