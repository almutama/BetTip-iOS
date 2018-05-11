//
//  MatchFormRows.swift
//  BetTip
//
//  Created by Haydar Karkin on 11.05.2018.
//  Copyright © 2018 Haydar Karkin. All rights reserved.
//

import Eureka

public final class MatchTextCell: _TextRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        add(rule: RuleRequired())
        validationOptions = .validatesOnChange
        cellSetup({ (cell, _) in
            cell.backgroundColor = .main
            cell.height = { 60 }
        })
    }
}

public final class MatchDecimalCell: _DecimalRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        add(rule: RuleRequired())
        validationOptions = .validatesOnChange
        cellSetup({ (cell, _) in
            cell.backgroundColor = .main
            cell.height = { 60 }
        })
    }
}

public final class MatchIntCell: _IntRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        add(rule: RuleRequired())
        validationOptions = .validatesOnChange
        cellSetup({ (cell, _) in
            cell.backgroundColor = .main
            cell.height = { 60 }
        })
    }
}

public final class MatchDateCell: _DateRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        title = tag
        add(rule: RuleRequired())
        validationOptions = .validatesOnChange
        cellSetup({ (cell, _) in
            cell.backgroundColor = .main
            cell.height = { 60 }
        })
    }
}

public final class MatchTimeCell: _TimeRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        title = tag
        add(rule: RuleRequired())
        validationOptions = .validatesOnChange
        cellSetup({ (cell, _) in
            cell.backgroundColor = .main
            cell.height = { 60 }
        })
    }
}

public final class MatchSwitchCell: _SwitchRow, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        title = tag
        add(rule: RuleRequired())
        validationOptions = .validatesOnChange
        cellSetup({ (cell, _) in
            cell.backgroundColor = .main
            cell.height = { 60 }
        })
    }
}
