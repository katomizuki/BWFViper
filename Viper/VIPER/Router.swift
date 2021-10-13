import Foundation
import UIKit
//Mark typelias
typealias EntryPoint = AnyView & UIViewController
//Mark AnyRouterProtocol
protocol AnyRouter {
    var entry:EntryPoint? { get }
    static func start()->AnyRouter
}
//Mark UserRouter
class UserRouter:AnyRouter {
    //Mark Properties
    var entry: EntryPoint?
    //Mark static Method
    static func start() -> AnyRouter {
        let router = UserRouter()
        var view:AnyView = BWFViewController()
        var presenter:AnyPresenter = BWFPresenter()
        var interactor:AnyInteractor = BWFInteractor()
        //Mark setup Presentar
        view.presentar = presenter
        interactor.presentar = presenter
        //Mark setupRouter
        presenter.router = router
        //Mark setupView
        presenter.view = view
        //Mark setup interactor
        presenter.interactor = interactor
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
