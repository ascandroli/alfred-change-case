import Foundation

struct Icon: Codable {
    let path: String
}

struct Item: Codable {
    let title: String
    let subtitle: String
    let arg: String
    let icon: Icon
}

func toLowercase(_ text: String) -> String {
    return text.lowercased()
}

func toUppercase(_ text: String) -> String {
    return text.uppercased()
}

func toTitlecase(_ text: String) -> String {
    return text.capitalized
}

func toCamelcase(_ text: String) -> String {
    return text.capitalized.replacingOccurrences(of: " ", with: "")
}

func toKebabcase(_ text: String) -> String {
    return text.lowercased().replacingOccurrences(of: "[ _]", with: "-", options: .regularExpression)
}

func toSnakecase(_ text: String) -> String {
    return text.lowercased().replacingOccurrences(of: "[ -]", with: "_", options: .regularExpression)
}

func toDotsSeparated(_ text: String) -> String {
    return text.replacingOccurrences(of: "[ _-]", with: ".", options: .regularExpression)
}

func toTerraformNaming(_ text: String) -> String {
    return addUnderscoreIfStartsWithDigit(text.replacingOccurrences(of: ".", with: "-"))
}

func addUnderscoreIfStartsWithDigit(_ identifier: String) -> String {
    return (CharacterSet.decimalDigits.contains(identifier.first?.unicodeScalars.first ?? UnicodeScalar(0)) ? "_" : "") + identifier
}

func main() {
    guard let text = CommandLine.arguments.dropFirst().first, !text.isEmpty else {
        print("Please provide a string as an argument.")
        return
    }

    let lowercaseText = toLowercase(text)
    let uppercaseText = toUppercase(text)
    let titlecaseText = toTitlecase(text)
    let camelcaseText = toCamelcase(text)
    let kebabcaseText = toKebabcase(text)
    let snakecaseText = toSnakecase(text)
    let dotsSeparatedText = toDotsSeparated(text)
    let terraformNamingText = toTerraformNaming(kebabcaseText)

    let items = [
        Item(title: "lower", subtitle: lowercaseText, arg: lowercaseText, icon: Icon(path: "lowercase.png")),
        Item(title: "upper", subtitle: uppercaseText, arg: uppercaseText, icon: Icon(path: "uppercase.png")),
        Item(title: "title", subtitle: titlecaseText, arg: titlecaseText, icon: Icon(path: "titlecase.png")),
        Item(title: "camel", subtitle: camelcaseText, arg: camelcaseText, icon: Icon(path: "camelcase.png")),
        Item(title: "kebab", subtitle: kebabcaseText, arg: kebabcaseText, icon: Icon(path: "kebabcase.png")),
        Item(title: "snake", subtitle: snakecaseText, arg: snakecaseText, icon: Icon(path: "snakecase.png")),
        Item(title: "dots", subtitle: dotsSeparatedText, arg: dotsSeparatedText, icon: Icon(path: "dots.png")),
        Item(title: "terraform", subtitle: terraformNamingText, arg: terraformNamingText, icon: Icon(path: "snakecase.png"))
    ]

    let output = ["items": items]
    if let jsonData = try? JSONEncoder().encode(output), let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    }
}

main()
