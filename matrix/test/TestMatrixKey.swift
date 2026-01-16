
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Testing

struct TestMatrixKey {

    @Test func test_2dKey() async throws {
        #expect( Matrix2dKey(y: 0x00000000, x: 0x00000000).value == 0x0000000000000000 )
        #expect( Matrix2dKey(y: 0x00000000, x: 0x0000000f).value == 0x000000000000000f )
        #expect( Matrix2dKey(y: 0x00000000, x: 0x000000f0).value == 0x00000000000000f0 )
        #expect( Matrix2dKey(y: 0x00000000, x: 0x00000f00).value == 0x0000000000000f00 )
        #expect( Matrix2dKey(y: 0x00000000, x: 0x0000f000).value == 0x000000000000f000 )
        #expect( Matrix2dKey(y: 0x00000000, x: 0x000f0000).value == 0x00000000000f0000 )
        #expect( Matrix2dKey(y: 0x00000000, x: 0x00f00000).value == 0x0000000000f00000 )
        #expect( Matrix2dKey(y: 0x00000000, x: 0x0f000000).value == 0x000000000f000000 )
        #expect( Matrix2dKey(y: 0x00000000, x: 0xf0000000).value == 0x00000000f0000000 )
        #expect( Matrix2dKey(y: 0x0000000f, x: 0x00000000).value == 0x0000000f00000000 )
        #expect( Matrix2dKey(y: 0x000000f0, x: 0x00000000).value == 0x000000f000000000 )
        #expect( Matrix2dKey(y: 0x00000f00, x: 0x00000000).value == 0x00000f0000000000 )
        #expect( Matrix2dKey(y: 0x0000f000, x: 0x00000000).value == 0x0000f00000000000 )
        #expect( Matrix2dKey(y: 0x000f0000, x: 0x00000000).value == 0x000f000000000000 )
        #expect( Matrix2dKey(y: 0x00f00000, x: 0x00000000).value == 0x00f0000000000000 )
        #expect( Matrix2dKey(y: 0x0f000000, x: 0x00000000).value == 0x0f00000000000000 )
        #expect( Matrix2dKey(y: 0xf0000000, x: 0x00000000).value == 0xf000000000000000 )

        #expect( Matrix2dKey(y: 0xffffffff, x: 0xffffffff).value == 0xffffffffffffffff )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0xfffffff0).value == 0xfffffffffffffff0 )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0xffffff0f).value == 0xffffffffffffff0f )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0xfffff0ff).value == 0xfffffffffffff0ff )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0xffff0fff).value == 0xffffffffffff0fff )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0xfff0ffff).value == 0xfffffffffff0ffff )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0xff0fffff).value == 0xffffffffff0fffff )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0xf0ffffff).value == 0xfffffffff0ffffff )
        #expect( Matrix2dKey(y: 0xffffffff, x: 0x0fffffff).value == 0xffffffff0fffffff )
        #expect( Matrix2dKey(y: 0xfffffff0, x: 0xffffffff).value == 0xfffffff0ffffffff )
        #expect( Matrix2dKey(y: 0xffffff0f, x: 0xffffffff).value == 0xffffff0fffffffff )
        #expect( Matrix2dKey(y: 0xfffff0ff, x: 0xffffffff).value == 0xfffff0ffffffffff )
        #expect( Matrix2dKey(y: 0xffff0fff, x: 0xffffffff).value == 0xffff0fffffffffff )
        #expect( Matrix2dKey(y: 0xfff0ffff, x: 0xffffffff).value == 0xfff0ffffffffffff )
        #expect( Matrix2dKey(y: 0xff0fffff, x: 0xffffffff).value == 0xff0fffffffffffff )
        #expect( Matrix2dKey(y: 0xf0ffffff, x: 0xffffffff).value == 0xf0ffffffffffffff )
        #expect( Matrix2dKey(y: 0x0fffffff, x: 0xffffffff).value == 0x0fffffffffffffff )
    }

    @Test func test_3dKey() async throws {
        #expect( Matrix3dKey(z: 0x0000, y: 0x0000, x: 0x0000).value == 0x000000000000 )
        #expect( Matrix3dKey(z: 0x0000, y: 0x0000, x: 0x000f).value == 0x00000000000f )
        #expect( Matrix3dKey(z: 0x0000, y: 0x0000, x: 0x00f0).value == 0x0000000000f0 )
        #expect( Matrix3dKey(z: 0x0000, y: 0x0000, x: 0x0f00).value == 0x000000000f00 )
        #expect( Matrix3dKey(z: 0x0000, y: 0x0000, x: 0xf000).value == 0x00000000f000 )
        #expect( Matrix3dKey(z: 0x0000, y: 0x000f, x: 0x0000).value == 0x0000000f0000 )
        #expect( Matrix3dKey(z: 0x0000, y: 0x00f0, x: 0x0000).value == 0x000000f00000 )
        #expect( Matrix3dKey(z: 0x0000, y: 0x0f00, x: 0x0000).value == 0x00000f000000 )
        #expect( Matrix3dKey(z: 0x0000, y: 0xf000, x: 0x0000).value == 0x0000f0000000 )
        #expect( Matrix3dKey(z: 0x000f, y: 0x0000, x: 0x0000).value == 0x000f00000000 )
        #expect( Matrix3dKey(z: 0x00f0, y: 0x0000, x: 0x0000).value == 0x00f000000000 )
        #expect( Matrix3dKey(z: 0x0f00, y: 0x0000, x: 0x0000).value == 0x0f0000000000 )
        #expect( Matrix3dKey(z: 0xf000, y: 0x0000, x: 0x0000).value == 0xf00000000000 )

        #expect( Matrix3dKey(z: 0xffff, y: 0xffff, x: 0xffff).value == 0xffffffffffff )
        #expect( Matrix3dKey(z: 0xffff, y: 0xffff, x: 0xfff0).value == 0xfffffffffff0 )
        #expect( Matrix3dKey(z: 0xffff, y: 0xffff, x: 0xff0f).value == 0xffffffffff0f )
        #expect( Matrix3dKey(z: 0xffff, y: 0xffff, x: 0xf0ff).value == 0xfffffffff0ff )
        #expect( Matrix3dKey(z: 0xffff, y: 0xffff, x: 0x0fff).value == 0xffffffff0fff )
        #expect( Matrix3dKey(z: 0xffff, y: 0xfff0, x: 0xffff).value == 0xfffffff0ffff )
        #expect( Matrix3dKey(z: 0xffff, y: 0xff0f, x: 0xffff).value == 0xffffff0fffff )
        #expect( Matrix3dKey(z: 0xffff, y: 0xf0ff, x: 0xffff).value == 0xfffff0ffffff )
        #expect( Matrix3dKey(z: 0xffff, y: 0x0fff, x: 0xffff).value == 0xffff0fffffff )
        #expect( Matrix3dKey(z: 0xfff0, y: 0xffff, x: 0xffff).value == 0xfff0ffffffff )
        #expect( Matrix3dKey(z: 0xff0f, y: 0xffff, x: 0xffff).value == 0xff0fffffffff )
        #expect( Matrix3dKey(z: 0xf0ff, y: 0xffff, x: 0xffff).value == 0xf0ffffffffff )
        #expect( Matrix3dKey(z: 0x0fff, y: 0xffff, x: 0xffff).value == 0x0fffffffffff )
    }

}
