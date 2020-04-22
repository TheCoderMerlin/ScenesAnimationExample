import Scenes

/*
   This class is responsible for implementing a single Scene.
   Scenes projects require at least one Scene but may have many.
   A Scene is comprised of one or more Layers.
   Layers are generally added in the constructor.
 */
class MainScene : Scene {

    let backgroundLayer = BackgroundLayer()
    let foregroundLayer = ForegroundLayer()

    init() {
        super.init(name:"Main")
        insert(layer:backgroundLayer, at:.back)
        insert(layer:foregroundLayer, at:.front)
    }
}
