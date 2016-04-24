// UIScreenExtension.swift
//
// Copyright (c) 2016 Tom Baranes
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public extension UIScreen {

    public static func screenOrientation() -> UIInterfaceOrientation {
        return UIApplication.sharedApplication().statusBarOrientation
    }
    
    public static func screenSize() -> CGSize {
        return CGSizeMake(screenWidth, screenHeight)
    }

    public static var screenWidth: CGFloat {
        return UIInterfaceOrientationIsPortrait(screenOrientation()) ? UIScreen.mainScreen().bounds.size.width : UIScreen.mainScreen().bounds.size.height
    }
    
    public static var screenHeight: CGFloat {
        return UIInterfaceOrientationIsPortrait(screenOrientation()) ? UIScreen.mainScreen().bounds.size.height : UIScreen.mainScreen().bounds.size.width
    }
    
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.sharedApplication().statusBarFrame.height
    }
    
    public static var screenHeightWithoutStatusBar: CGFloat {
        return UIInterfaceOrientationIsPortrait(screenOrientation()) ? UIScreen.mainScreen().bounds.size.height - screenStatusBarHeight :
            UIScreen.mainScreen().bounds.size.width - screenStatusBarHeight
    }
    
}