# Melatonin

Melatonin is a declarative HTTP request library for Swift designed to simplify and streamline the process of building and managing HTTP requests. It combines a composable design inspired by SwiftUI with type-safe networking primitives, enabling clean and reusable code.

---

## Features

- Declarative HTTP request building using `HTTPCall` and `Endpoint`.
- Built-in modifiers for headers, query parameters, body, and HTTP methods.
- `HTTPService` protocol for managing networking logic.
- Type-safe and composable API for better readability and maintainability.

---

## Installation

To use Melatonin in your Swift project, add it as a dependency via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/the-braveknight/Melatonin.git", from: "0.3.0")
]
```

---

## Usage

### Define a Base Call (`HTTPCall`)

The `HTTPCall` protocol is the foundation for HTTP requests. Base requests construct a `URLRequest` pointing to the API URL.

```swift
import Foundation

struct GoRESTCall: HTTPCall {
    func build() -> URLRequest {
        URLRequest(url: URL(string: "https://gorest.co.in/public/v2")!)
    }
}
```

### Create an Endpoint (`Endpoint`)

The `Endpoint` protocol is used to define specific API calls. The `call` property composes the request using modifiers.

```swift
import Foundation

struct GetUsers: Endpoint {
    var call: some HTTPCall {
        GoRESTCall()
            .method(.get)
            .path("/users")
            .accept(.json)
    }
}
```

---

## Creating an HTTP Service (`HTTPService`)

The `GoRESTService` actor implements the `HTTPService` protocol and provides methods to perform requests and process responses.

### Define the Response Model

```swift
import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
}
```

### Implement the `GoRESTService` Actor

```swift
import Foundation

actor GoRESTService: HTTPService {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchUsers() async throws -> [User] {
        let endpoint = GetUsers()
        let call = endpoint.call
        let (data, _) = try await load(call)
        return try JSONDecoder().decode([User].self, from: data)
    }
}
```

---

### Extend the `GoRESTService` Actor: Adding Authentication

For many APIs, authentication is required to access resources. This logic can be added incrementally to the `GoRESTService` implementation.

#### Define the `TokenProvider` Protocol

The `TokenProvider` protocol inherits from `Actor` to ensure thread safety and implements the `accessToken()` method for securely retrieving tokens.

```swift
import Foundation

protocol TokenProvider: Actor {
    func accessToken() throws -> String
}
```

#### Update the `GoRESTService` Actor with Authentication Logic

Here’s how the same `GoRESTService` actor is updated to include token management via the `TokenProvider`.

```swift
import Foundation

actor GoRESTService: HTTPService {
    let session: URLSession
    private let tokenProvider: TokenProvider

    init(session: URLSession = .shared, tokenProvider: TokenProvider) {
        self.session = session
        self.tokenProvider = tokenProvider
    }

    func fetchUsers() async throws -> [User] {
        let endpoint = GetUsers()

        // Retrieve the token and apply it using the .auth(.bearer) modifier
        let token = try await tokenProvider.accessToken()
        let callWithAuth = endpoint.call.auth(.bearer(token))

        let (data, _) = try await load(callWithAuth)
        return try JSONDecoder().decode([User].self, from: data)
    }
}
```

---

#### Example `TokenProvider` Implementation

The `SecureTokenProvider` securely retrieves the token from a storage mechanism like the Keychain.

```swift
actor SecureTokenProvider: TokenProvider {
    private var token: String?

    func accessToken() throws -> String {
        if let token = token {
            return token
        } else {
            throw URLError(.userAuthenticationRequired)
        }
    }

    func setToken(_ newToken: String) {
        token = newToken
    }
}
```

---

#### Why Add Authentication?

The initial `GoRESTService` implementation works for open APIs. However, when working with APIs requiring authentication, the `TokenProvider` allows secure token management without significantly altering the service’s core structure. This approach keeps the HTTP service extensible and adaptable to evolving requirements.

---

#### Using the `GoRESTService` Actor with Authentication Logic

Here’s how to initialize and use the updated `GoRESTService` with the `SecureTokenProvider`:

```swift
let tokenProvider = SecureTokenProvider()
let service = GoRESTService(tokenProvider: tokenProvider)

Task {
    do {
        let users = try await service.fetchUsers()
        print("Fetched users: \(users)")
    } catch {
        print("Error fetching users: \(error)")
    }
}
```

---

## Built-In Modifiers

### HTTP Headers

- `accept(_:)`: Sets the `Accept` header.
- `contentType(_:)`: Sets the `Content-Type` header.
- `authorization(_:)`: Adds an `Authorization` header.
- `userAgent(_:)`: Sets a custom `User-Agent`.

### Request Properties

- `method(_:)`: Modifies the HTTP method.
- `path(_:)`: Appends path to the request.
- `queries(_:)`: Appends query parameters to the URL.
- `body(_:)`: Adds a request body.

---

## Why Melatonin?

Melatonin leverages Swift’s type safety and declarative programming principles to create a robust and flexible networking library. Its composable design and extensibility make it ideal for modern Swift applications.

---

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve Melatonin.

---

## License

Melatonin is released under the MIT License. See [LICENSE](./LICENSE) for details.

---
