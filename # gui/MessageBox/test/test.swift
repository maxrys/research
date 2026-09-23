
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Testing

struct test {

    @Test func Checksums_crc32() async throws {
        assert(Checksums.crc32("") == 0x0000_0000)
        assert(Checksums.crc32("123456789") == 0xcbf4_3926)
    }

}
