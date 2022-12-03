import UIKit


/*
 Here aim is to create types which full fill the following requirements:

 - Create an image given a name and image data
 - The image should be persisted to and loaded from the filesystem
 - Create a lossy compressed version of the image
 - Base64 encode the image for transferring it over the internet

 */

//MARK: - Superclass Way
class Image {
    fileprivate var imageName: String
    fileprivate var imageData: Data

    var name: String {
        return imageName
    }

    init(name: String, data: Data) {
        imageName = name
        imageData = data
    }

    //persistance
    func save(to url: URL) throws {
        try self.imageData.write(to: url)
    }

    convenience init(name: String, contentsOf url: URL) throws {
        let data = try Data(contentsOf: url)
        self.init(name: name, data: data)
    }

    //compression
    convenience init?(named name: String, data: Data, compressionQuality: Double) {
        guard let image = UIImage.init(data: data) else {return nil}
        guard let jpegData = image.jpegData(compressionQuality: CGFloat(compressionQuality)) else { return nil }
        self.init(name: name, data: jpegData)
    }

    //BASE64 encoding
    var base64Encoding: String {
        return imageData.base64EncodedString()
    }
}

//Test
var image = Image(name: "Pic", data: Data(repeating: 0, count: 100))
print(image.base64Encoding)

do {
    //persist image
    let documentDirectory = try FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let imageUrl = URL(string: documentDirectory!.absoluteString)!
    try image.save(to: imageUrl)
    print("Image saved successfully to path \(imageUrl)")

    //load image from persistence
    let storeImage = try Image.init(name: "MyRestoredImage", contentsOf: imageUrl)
    print("Image loader successfully from path \(imageUrl)")
} catch {
    print(error)
}


//MARK: - POP Way
protocol NamedImageData {
    var name: String { get }
    var data: Data { get }
    init(name: String, data: Data)
}

protocol ImageDataPersisting: NamedImageData {
    init(name: String, contentsOf url: URL) throws
    func save(to url: URL) throws
}

extension ImageDataPersisting {
    init(name: String, contentsOf url: URL) throws {
        let data = try Data(contentsOf: url)
        self.init(name: name, data: data)
    }

    func save(to url: URL) throws {
        try self.data.write(to: url)
    }
}

protocol ImageDataCompressing: NamedImageData {
    func compress(withQuality compressionQuality: Double) -> Self?
}

extension ImageDataCompressing {
    func compress(withQuality compressionQuality: Double) -> Self?  {
        guard let uiImage = UIImage.init(data: self.data) else {
            return nil
        }

        guard let jpegData = uiImage.jpegData(compressionQuality: CGFloat(compressionQuality)) else {
            return nil
        }

        return Self(name: self.name, data: jpegData)
    }
}

protocol ImageDataEncoding: NamedImageData {
    var base64Encoding: String { get }
}

extension ImageDataEncoding {
    var base64Encoding: String {
        return self.data.base64EncodedString()
    }
}

struct MyImage: ImageDataPersisting, ImageDataCompressing, ImageDataEncoding {
    var name: String
    var data: Data
}

var myImage = MyImage(name: "Pic", data: Data(repeating: 0, count: 100))
print(myImage.base64Encoding)

do {
    let myImageDocumentDirectory = try FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let myImageUrl = URL(string: myImageDocumentDirectory!.absoluteString)!
    try myImage.save(to: myImageUrl)
    print("Image saved successfully to path \(myImageUrl)")

    //load image from persistence
    let storeImage = try Image.init(name: "MyRestoredImage", contentsOf: myImageUrl)
    print("Image loader successfully from path \(myImageUrl)")
} catch {
    print(error)
}

