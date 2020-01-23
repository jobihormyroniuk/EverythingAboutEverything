//
//  AnyFormatKitTextInputFormatterAdapterToAUITextInputFormatter.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 1/22/20.
//  Copyright © 2020 Ihor Myroniuk. All rights reserved.
//

import AnyFormatKit
import AUIKit

class AnyFormatKitTextInputFormatterAdapterToAUITextInputFormatter: AUITextInputFormatter {

    let anyFormatKitTextInputFormatter: TextInputFormatter

    init(anyFormatKitTextInputFormatter: TextInputFormatter) {
        self.anyFormatKitTextInputFormatter = anyFormatKitTextInputFormatter
    }

    func format(text: String?) -> String? {
        return anyFormatKitTextInputFormatter.format(text)
    }

    func unformat(formattedText: String?) -> String? {
        return anyFormatKitTextInputFormatter.unformat(formattedText)
    }

    func formatInputtedText(currentText: String?, range: NSRange, replacementString text: String?) -> AUIInputtedTextFormatterResult {
        let result = anyFormatKitTextInputFormatter.formatInput(currentText: currentText ?? "", range: range, replacementString: text ?? "")
        return (formattedText: result.formattedText, caretBeginOffset: result.caretBeginOffset)
    }

}
