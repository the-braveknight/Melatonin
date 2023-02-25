### Melatonin

Melatonin (formerly SwiftyNetworking) library is a networking library written in Swift that provides a protocol-oriented approach to load network requests. It provides a protocol `Endpoint` to ensure that networking requests are parsed in a generic and type-safe way.

#### Endpoint Protocol
Conformance to `Endpoint` protocol is easy and straighforward. This is how the protocol body looks like:
```swift
public protocol Endpoint {
    associatedtype Response
    
    var scheme: Scheme { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queries: [URLQueryItem] { get }
    var headers: [HTTPHeader] { get }
    func prepare(request: inout URLRequest)
    func parse(data: Data, urlResponse: URLResponse) throws -> Response
}

```
The library includes default implementations for some of the required variables and functions for convenience.

### Constructing the URLRequest
Any object conforming to `Endpoint` will automatically get `url` and `request` properites which will be used by `URLSession` to load the request.

You can implement the **prepare(request:)** method if you need to modify the request before it is loaded.

#### @Query property wrapper
The **@Query** property wrapper is used to declare any property that is a URL query. All properties declared with **@Query** inside your endpoint's body will be added to the final url.

```swift
struct APIEndpoint: Endpoint {
    ...
    @Query(name: "name") var name: String? = "the-braveknight"
    @Query(name: "age") var pageNumber: String? = "2"
    ...
}
```
In the above code, the url query will look like this: `?name=the-braveknight&pageNumber=2`. You can still add multiple queries by directly setting the `queries` property of your endpoint.

#### @Header property wrapper
Similarly, the **@Header** property wrapper is used to declare headers, which will be added the `URLRequest` before it's loaded. The library contains multiple commonly used HTTP headers and you can also implement your own.

```swift
struct APIEndpoint: Endpoint {
    ...
    @Header(\.accept) var accept: MIMEType = .json
    @Header(\.contentType) var contentType: MIMEType = .json
    ...
}
```
Again, you can still add multiple headers at once by directly setting the `headers` property of your endpoint.

### Decoding the response
In certain cases, for example when the `Response` conforms to `Decodable` and we expect to decode JSON, it would be reasonable to provide default implementation for **parse(data:urlResponse:)** method to handle that automatically.
```swift
public extension Endpoint where Response : Decodable {
    func parse(data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}
```
You can still provide your own implementation of this method to override this implementation.

### An Example Endpoint
This is an example endpoint with `GET` method to parse requests from [Agify.io](https://agify.io/ "Agify.io") API.

The response body from an API call (https://api.agify.io/?name=bella) looks like this:
```json
{
    "name" : "bella",
    "age" : 34,
    "count" : 40138
}
```
A custom Swift struct that can contain this data would look like this:
```swift
struct Person : Decodable {
    let name: String
    let age: Int
}
```
Finally, here is how our endpoint will look like:
```swift
struct AgifyAPIEndpoint : Endpoint {
    typealias Response = Person
    
    let host: String = "api.agify.io"
    let path: String = "/"
    @Query(name: "name") var name: String? = nil
    @Header(\.accept) var accept: MIMEType = .json
}
```

We could use the Swift dot syntax to make it more convenient to call our endpoint.
```swift
extension Endpoint where Self == AgifyAPIEndpoint {
    static func estimatedAge(forName personName: String) -> Self {
        AgifyAPIEndpoint(name: personName)
    }
}
```
Finally, this is how we would call our endpoint. The result is of type `Result<Person, Error>`.
```swift
URLSession.shared.load(.estimatedAge(forName: "Zaid")) { result in
    do {
        let person = try result.get()
        print("\(person.name) is probably \(person.age) years old.")
    } catch {
        // Handle errors
    }
}
```
### Combine
Melatonin supports loading endpoints using `Combine` framework.
```swift
let subscription: AnyCancellable = URLSession.shared.load(.estimatedAge(forName: "Zaid"))
    .sink { completion in
        // Handle errors
    } receiveValue: { person in
        print("\(person.name) is probably \(person.age) years old.")
    }
```
### Swift Concurrency
Melatonin also supports loading an endpoint using Swift Concurrency and `async/await`.
```swift
Task {
    do {
        let person = try await URLSession.shared.load(.estimatedAge(forName: "Zaid"))
        print("\(person.name) is probably \(person.age) years old.")
    } catch {
        // Handle errors
    }
}
```

### Credits
- John Sundell from [SwiftBySundell](https://www.swiftbysundell.com "SwiftBySundell") for the inspiration.

