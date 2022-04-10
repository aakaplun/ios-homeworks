//
//  ProfileHeaderViewDelegate.swift
//  Navigation
//
//  Created by Andrey Kaplun on 10/04/2022.
//  Copyright © 2022 Andrey Kaplun. All rights reserved.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func setHeaderViewState(_ state: ProfileHeaderView.Status)
    func beginUpdates()
    func endUpdates()
    func expandAvatar()
}
