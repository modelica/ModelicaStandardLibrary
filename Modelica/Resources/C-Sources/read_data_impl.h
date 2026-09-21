/*
 * Copyright (c) 2015-2026, The matio contributors
 * Copyright (c) 2019-2014, Christopher C. Hulbert
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define READ_TYPE_DOUBLE_DATA CAT(READ_TYPED_FUNC1, Double)
#define READ_TYPE_SINGLE_DATA CAT(READ_TYPED_FUNC1, Single)
#define READ_TYPE_INT32_DATA CAT(READ_TYPED_FUNC1, Int32)
#define READ_TYPE_UINT32_DATA CAT(READ_TYPED_FUNC1, UInt32)
#define READ_TYPE_INT16_DATA CAT(READ_TYPED_FUNC1, Int16)
#define READ_TYPE_UINT16_DATA CAT(READ_TYPED_FUNC1, UInt16)
#define READ_TYPE_INT8_DATA CAT(READ_TYPED_FUNC1, Int8)
#define READ_TYPE_UINT8_DATA CAT(READ_TYPED_FUNC1, UInt8)
#ifdef HAVE_MATIO_INT64_T
#define READ_TYPE_INT64_DATA CAT(READ_TYPED_FUNC1, Int64)
#endif /* HAVE_MATIO_INT64_T */
#ifdef HAVE_MATIO_UINT64_T
#define READ_TYPE_UINT64_DATA CAT(READ_TYPED_FUNC1, UInt64)
#endif /* HAVE_MATIO_UINT64_T */

static int
READ_TYPE_DOUBLE_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_DOUBLE
    readCount = fread(data, sizeof(double), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_doubleSwap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(double);
    double v[READ_BLOCK_SIZE / sizeof(double)];
    READ_DATA(READ_TYPE, Mat_doubleSwap);
#endif
    return err;
}

static int
READ_TYPE_SINGLE_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_SINGLE
    readCount = fread(data, sizeof(float), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_floatSwap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(float);
    float v[READ_BLOCK_SIZE / sizeof(float)];
    READ_DATA(READ_TYPE, Mat_floatSwap);
#endif
    return err;
}

static int
READ_TYPE_INT32_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT32
    readCount = fread(data, sizeof(mat_int32_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_int32Swap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(mat_int32_t);
    mat_int32_t v[READ_BLOCK_SIZE / sizeof(mat_int32_t)];
    READ_DATA(READ_TYPE, Mat_int32Swap);
#endif
    return err;
}

static int
READ_TYPE_UINT32_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT32
    readCount = fread(data, sizeof(mat_uint32_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_uint32Swap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(mat_uint32_t);
    mat_uint32_t v[READ_BLOCK_SIZE / sizeof(mat_uint32_t)];
    READ_DATA(READ_TYPE, Mat_uint32Swap);
#endif
    return err;
}

static int
READ_TYPE_INT16_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT16
    readCount = fread(data, sizeof(mat_int16_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_int16Swap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(mat_int16_t);
    mat_int16_t v[READ_BLOCK_SIZE / sizeof(mat_int16_t)];
    READ_DATA(READ_TYPE, Mat_int16Swap);
#endif
    return err;
}

static int
READ_TYPE_UINT16_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT16
    readCount = fread(data, sizeof(mat_uint16_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_uint16Swap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(mat_uint16_t);
    mat_uint16_t v[READ_BLOCK_SIZE / sizeof(mat_uint16_t)];
    READ_DATA(READ_TYPE, Mat_uint16Swap);
#endif
    return err;
}

static int
READ_TYPE_INT8_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT8
    readCount = fread(data, sizeof(mat_int8_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
#else
    size_t i;
    const size_t data_size = sizeof(mat_int8_t);
    mat_int8_t v[READ_BLOCK_SIZE / sizeof(mat_int8_t)];
    READ_DATA_NOSWAP(READ_TYPE);
#endif
    return err;
}

static int
READ_TYPE_UINT8_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT8
    readCount = fread(data, sizeof(mat_uint8_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
#else
    size_t i;
    const size_t data_size = sizeof(mat_uint8_t);
    mat_uint8_t v[READ_BLOCK_SIZE / sizeof(mat_uint8_t)];
    READ_DATA_NOSWAP(READ_TYPE);
#endif
    return err;
}

#ifdef HAVE_MATIO_INT64_T
static int
READ_TYPE_INT64_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT64
    readCount = fread(data, sizeof(mat_int64_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_int64Swap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(mat_int64_t);
    mat_int64_t v[READ_BLOCK_SIZE / sizeof(mat_int64_t)];
    READ_DATA(READ_TYPE, Mat_int64Swap);
#endif
    return err;
}
#endif /* HAVE_MATIO_INT64_T */

#ifdef HAVE_MATIO_UINT64_T
static int
READ_TYPE_UINT64_DATA(mat_t *mat, READ_TYPE *data, size_t len)
{
    size_t readCount;
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT64
    readCount = fread(data, sizeof(mat_uint64_t), len, (FILE *)mat->fp);
    if ( readCount != len ) {
        return MATIO_E_GENERIC_READ_ERROR;
    }
    err = MATIO_E_NO_ERROR;
    if ( mat->byteswap ) {
        size_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_uint64Swap(data + i);
        }
    }
#else
    size_t i;
    const size_t data_size = sizeof(mat_uint64_t);
    mat_uint64_t v[READ_BLOCK_SIZE / sizeof(mat_uint64_t)];
    READ_DATA(READ_TYPE, Mat_uint64Swap);
#endif
    return err;
}
#endif /* HAVE_MATIO_UINT64_T */

/** @brief Reads data of type @c data_type into a READ_TYPE type
 *
 * Reads from the MAT file @c len elements of data type @c data_type storing
 * them as READ_TYPE's in @c data.
 * @ingroup mat_internal
 * @param mat MAT file pointer
 * @param data Pointer to store the output values (len*sizeof(READ_TYPE))
 * @param data_type one of the @c matio_types enumerations which is the source
 *                  data type in the file
 * @param len Number of elements of type @c data_type to read from the file
 * @retval 0 on success
 */
static int
READ_TYPED_FUNC1(mat_t *mat, READ_TYPE *data, enum matio_types data_type, size_t len)
{
    if ( mat == NULL || data == NULL || mat->fp == NULL )
        return MATIO_E_BAD_ARGUMENT;

    switch ( data_type ) {
        case MAT_T_DOUBLE:
            return READ_TYPE_DOUBLE_DATA(mat, data, len);
        case MAT_T_SINGLE:
            return READ_TYPE_SINGLE_DATA(mat, data, len);
#ifdef HAVE_MATIO_INT64_T
        case MAT_T_INT64:
            return READ_TYPE_INT64_DATA(mat, data, len);
#endif /* HAVE_MATIO_UINT64_T */
#ifdef HAVE_MATIO_UINT64_T
        case MAT_T_UINT64:
            return READ_TYPE_UINT64_DATA(mat, data, len);
#endif /* HAVE_MATIO_UINT64_T */
        case MAT_T_INT32:
            return READ_TYPE_INT32_DATA(mat, data, len);
        case MAT_T_UINT32:
            return READ_TYPE_UINT32_DATA(mat, data, len);
        case MAT_T_INT16:
            return READ_TYPE_INT16_DATA(mat, data, len);
        case MAT_T_UINT16:
            return READ_TYPE_UINT16_DATA(mat, data, len);
        case MAT_T_INT8:
            return READ_TYPE_INT8_DATA(mat, data, len);
        case MAT_T_UINT8:
            return READ_TYPE_UINT8_DATA(mat, data, len);
        default:
            break;
    }
    return MATIO_E_GENERIC_READ_ERROR;
}

#undef READ_TYPE_DOUBLE_DATA
#undef READ_TYPE_SINGLE_DATA
#undef READ_TYPE_INT32_DATA
#undef READ_TYPE_UINT32_DATA
#undef READ_TYPE_INT16_DATA
#undef READ_TYPE_UINT16_DATA
#undef READ_TYPE_INT8_DATA
#undef READ_TYPE_UINT8_DATA
#ifdef HAVE_MATIO_INT64_T
#undef READ_TYPE_INT64_DATA
#endif /* HAVE_MATIO_INT64_T */
#ifdef HAVE_MATIO_UINT64_T
#undef READ_TYPE_UINT64_DATA
#endif /* HAVE_MATIO_UINT64_T */

#if HAVE_ZLIB

#define READ_TYPE_DOUBLE_DATA CAT(READ_TYPED_FUNC2, Double)
#define READ_TYPE_SINGLE_DATA CAT(READ_TYPED_FUNC2, Single)
#define READ_TYPE_INT32_DATA CAT(READ_TYPED_FUNC2, Int32)
#define READ_TYPE_UINT32_DATA CAT(READ_TYPED_FUNC2, UInt32)
#define READ_TYPE_INT16_DATA CAT(READ_TYPED_FUNC2, Int16)
#define READ_TYPE_UINT16_DATA CAT(READ_TYPED_FUNC2, UInt16)
#define READ_TYPE_INT8_DATA CAT(READ_TYPED_FUNC2, Int8)
#define READ_TYPE_UINT8_DATA CAT(READ_TYPED_FUNC2, UInt8)
#ifdef HAVE_MATIO_INT64_T
#define READ_TYPE_INT64_DATA CAT(READ_TYPED_FUNC2, Int64)
#endif /* HAVE_MATIO_INT64_T */
#ifdef HAVE_MATIO_UINT64_T
#define READ_TYPE_UINT64_DATA CAT(READ_TYPED_FUNC2, UInt64)
#endif /* HAVE_MATIO_UINT64_T */

static int
READ_TYPE_DOUBLE_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_DOUBLE
    err = InflateData(mat, z, data, len * sizeof(double));
    if ( err ) {
        return err;
    }
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_doubleSwap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(double);
    double v[READ_BLOCK_SIZE / sizeof(double)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_doubleSwap);
#endif
    return err;
}

static int
READ_TYPE_SINGLE_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_SINGLE
    err = InflateData(mat, z, data, len * sizeof(float));
    if ( err ) {
        return err;
    }
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_floatSwap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(float);
    float v[READ_BLOCK_SIZE / sizeof(float)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_floatSwap);
#endif
    return err;
}

#ifdef HAVE_MATIO_INT64_T
static int
READ_TYPE_INT64_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT64
    err = InflateData(mat, z, data, len * sizeof(mat_int64_t));
    if ( err ) {
        return err;
    }
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_int64Swap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_int64_t);
    mat_int64_t v[READ_BLOCK_SIZE / sizeof(mat_int64_t)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_int64Swap);
#endif
    return err;
}
#endif /* HAVE_MATIO_INT64_T */

#ifdef HAVE_MATIO_UINT64_T
static int
READ_TYPE_UINT64_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT64
    err = InflateData(mat, z, data, len * sizeof(mat_uint64_t));
    if ( err ) {
        return err;
    }
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_uint64Swap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_uint64_t);
    mat_uint64_t v[READ_BLOCK_SIZE / sizeof(mat_uint64_t)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_uint64Swap);
#endif
    return err;
}
#endif /* HAVE_MATIO_UINT64_T */

static int
READ_TYPE_INT32_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT32
    err = InflateData(mat, z, data, len * sizeof(mat_int32_t));
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_int32Swap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_int32_t);
    mat_int32_t v[READ_BLOCK_SIZE / sizeof(mat_int32_t)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_int32Swap);
#endif
    return err;
}

static int
READ_TYPE_UINT32_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT32
    err = InflateData(mat, z, data, len * sizeof(mat_uint32_t));
    if ( err ) {
        return err;
    }
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_uint32Swap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_uint32_t);
    mat_uint32_t v[READ_BLOCK_SIZE / sizeof(mat_uint32_t)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_uint32Swap);
#endif
    return err;
}

static int
READ_TYPE_INT16_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT16
    err = InflateData(mat, z, data, len * sizeof(mat_int16_t));
    if ( err ) {
        return err;
    }
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_int16Swap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_int16_t);
    mat_int16_t v[READ_BLOCK_SIZE / sizeof(mat_int16_t)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_int16Swap);
#endif
    return err;
}

static int
READ_TYPE_UINT16_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT16
    err = InflateData(mat, z, data, len * sizeof(mat_uint16_t));
    if ( err ) {
        return err;
    }
    if ( mat->byteswap ) {
        mat_uint32_t i;
        for ( i = 0; i < len; i++ ) {
            (void)Mat_uint16Swap(data + i);
        }
    }
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_uint16_t);
    mat_uint16_t v[READ_BLOCK_SIZE / sizeof(mat_uint16_t)];
    READ_COMPRESSED_DATA(READ_TYPE, Mat_uint16Swap);
#endif
    return err;
}

static int
READ_TYPE_INT8_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_INT8
    err = InflateData(mat, z, data, len * sizeof(mat_int8_t));
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_int8_t);
    mat_int8_t v[READ_BLOCK_SIZE / sizeof(mat_int8_t)];
    READ_COMPRESSED_DATA_NOSWAP(READ_TYPE);
#endif
    return err;
}

static int
READ_TYPE_UINT8_DATA(mat_t *mat, z_streamp z, READ_TYPE *data, mat_uint32_t len)
{
    int err;
#if READ_TYPE_TYPE == READ_TYPE_UINT8
    err = InflateData(mat, z, data, len * sizeof(mat_uint8_t));
#else
    mat_uint32_t i;
    const size_t data_size = sizeof(mat_uint8_t);
    mat_uint8_t v[READ_BLOCK_SIZE / sizeof(mat_uint8_t)];
    READ_COMPRESSED_DATA_NOSWAP(READ_TYPE);
#endif
    return err;
}

/** @brief Reads data of type @c data_type into a READ_TYPE type
 *
 * Reads from the MAT file @c len compressed elements of data type @c data_type
 * storing them as READ_TYPE's in @c data.
 * @ingroup mat_internal
 * @param mat MAT file pointer
 * @param z Pointer to the zlib stream for inflation
 * @param data Pointer to store the output values (len*sizeof(READ_TYPE))
 * @param data_type one of the @c matio_types enumerations which is the source
 *                  data type in the file
 * @param len Number of elements of type @c data_type to read from the file
 * @retval 0 on success
 */
int
READ_TYPED_FUNC2(mat_t *mat, z_streamp z, READ_TYPE *data, enum matio_types data_type, int len)
{
    if ( mat == NULL || data == NULL || mat->fp == NULL )
        return MATIO_E_BAD_ARGUMENT;

    switch ( data_type ) {
        case MAT_T_DOUBLE:
            return READ_TYPE_DOUBLE_DATA(mat, z, data, len);
        case MAT_T_SINGLE:
            return READ_TYPE_SINGLE_DATA(mat, z, data, len);
#ifdef HAVE_MATIO_INT64_T
        case MAT_T_INT64:
            return READ_TYPE_INT64_DATA(mat, z, data, len);
#endif /* HAVE_MATIO_UINT64_T */
#ifdef HAVE_MATIO_UINT64_T
        case MAT_T_UINT64:
            return READ_TYPE_UINT64_DATA(mat, z, data, len);
#endif /* HAVE_MATIO_UINT64_T */
        case MAT_T_INT32:
            return READ_TYPE_INT32_DATA(mat, z, data, len);
        case MAT_T_UINT32:
            return READ_TYPE_UINT32_DATA(mat, z, data, len);
        case MAT_T_INT16:
            return READ_TYPE_INT16_DATA(mat, z, data, len);
        case MAT_T_UINT16:
            return READ_TYPE_UINT16_DATA(mat, z, data, len);
        case MAT_T_INT8:
            return READ_TYPE_INT8_DATA(mat, z, data, len);
        case MAT_T_UINT8:
            return READ_TYPE_UINT8_DATA(mat, z, data, len);
        default:
            break;
    }
    return MATIO_E_GENERIC_READ_ERROR;
}

#undef READ_TYPE_DOUBLE_DATA
#undef READ_TYPE_SINGLE_DATA
#undef READ_TYPE_INT32_DATA
#undef READ_TYPE_UINT32_DATA
#undef READ_TYPE_INT16_DATA
#undef READ_TYPE_UINT16_DATA
#undef READ_TYPE_INT8_DATA
#undef READ_TYPE_UINT8_DATA
#ifdef HAVE_MATIO_INT64_T
#undef READ_TYPE_INT64_DATA
#endif /* HAVE_MATIO_INT64_T */
#ifdef HAVE_MATIO_UINT64_T
#undef READ_TYPE_UINT64_DATA
#endif /* HAVE_MATIO_UINT64_T */

#endif
