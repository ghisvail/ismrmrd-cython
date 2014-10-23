from libc.stdint cimport uint16_t, uint32_t, uint64_t, int32_t
from libcpp.string cimport string

cdef extern from "ismrmrd/ismrmrd.h" namespace "ISMRMRD":
    
    cdef enum:
        ISMRMRD_VERSION = 1
        ISMRMRD_USER_INTS = 8
        ISMRMRD_USER_FLOATS = 8
        ISMRMRD_PHYS_STAMPS = 3
        ISMRMRD_CHANNEL_MASKS = 16
        ISMRMRD_NDARRAY_MAXDIM = 7
        ISMRMRD_POSITION_LENGTH = 3
        ISMRMRD_DIRECTION_LENGTH = 3

    cdef cppclass EncodingCounters:
        uint16_t kspace_encode_step_1       # e.g. phase encoding line number
        uint16_t kspace_encode_step_2       # e.g. partition encodning number
        uint16_t average                    # e.g. signal average number
        uint16_t slice                      # e.g. imaging slice number
        uint16_t contrast                   # e.g. echo number in multi-echo
        uint16_t phase                      # e.g. cardiac phase number
        uint16_t repetition                 # e.g. dynamic number for dynamic scanning
        uint16_t set                        # e.g. flow encodning set
        uint16_t segment                    # e.g. segment number for segmented acquisition
        uint16_t user[ISMRMRD_USER_INTS]    # Free user parameters

    cdef cppclass AcquisitionHeader:
        uint16_t version                    # First unsigned int indicates the version
        uint64_t flags                      # bit field with flags
        uint32_t measurement_uid            # Unique ID for the measurement
        uint32_t scan_counter               # Current acquisition number in the measurement
        uint32_t acquisition_time_stamp     # Acquisition clock
        uint32_t physiology_time_stamp[ISMRMRD_PHYS_STAMPS]     # Physiology time stamps, e.g. ecg, breating, etc.
        uint16_t number_of_samples          # Number of samples acquired
        uint16_t available_channels         # Available coils
        uint16_t active_channels            # Active coils on current acquisiton
        uint64_t channel_mask[ISMRMRD_CHANNEL_MASKS]    # Mask to indicate which channels are active. Support for 1024 channels
        uint16_t discard_pre                # Samples to be discarded at the beginning of acquisition
        uint16_t discard_post               # Samples to be discarded at the end of acquisition
        uint16_t center_sample              # Sample at the center of k-space
        uint16_t encoding_space_ref         # Reference to an encoding space, typically only one per acquisition
        uint16_t trajectory_dimensions      # Indicates the dimensionality of the trajectory vector (0 means no trajectory)
        float sample_time_us                # Time between samples in micro seconds, sampling BW
        float position[ISMRMRD_POSITION_LENGTH]         # Three-dimensional spatial offsets from isocenter
        float read_dir[ISMRMRD_DIRECTION_LENGTH]        # Directional cosines of the readout/frequency encoding
        float phase_dir[ISMRMRD_DIRECTION_LENGTH]       # Directional cosines of the phase
        float slice_dir[ISMRMRD_DIRECTION_LENGTH]       # Directional cosines of the slice direction
        float patient_table_position[ISMRMRD_POSITION_LENGTH]  # Patient table off-center
        EncodingCounters idx                            # Encoding loop counters, see above
        int32_t user_int[ISMRMRD_USER_INTS]             # Free user parameters
        float user_float[ISMRMRD_USER_FLOATS]           # Free user parameters

    ctypedef struct complex_float_t:
        pass

    cdef cppclass Acquisition:
        AcquisitionHeader& getHead()
        void setHead(const AcquisitionHeader)
        complex_float_t* getData()
        float *getTraj()

    cdef enum ISMRMRD_ImageDataTypes:
        ISMRMRD_USHORT
        ISMRMRD_SHORT
        ISMRMRD_UINT
        ISMRMRD_INT
        ISMRMRD_FLOAT
        ISMRMRD_DOUBLE
        ISMRMRD_CXFLOAT
        ISMRMRD_CXDOUBLE

    cdef enum ISMRMRD_ImageTypes:
        ISMRMRD_IMTYPE_MAGNITUDE
        ISMRMRD_IMTYPE_PHASE
        ISMRMRD_IMTYPE_REAL
        ISMRMRD_IMTYPE_IMAG
        ISMRMRD_IMTYPE_COMPLEX

    cdef enum ISMRMRD_ImageFlags:
        ISMRMRD_IMAGE_IS_NAVIGATION_DATA
        ISMRMRD_IMAGE_USER1
        ISMRMRD_IMAGE_USER2
        ISMRMRD_IMAGE_USER3
        ISMRMRD_IMAGE_USER4
        ISMRMRD_IMAGE_USER5
        ISMRMRD_IMAGE_USER6
        ISMRMRD_IMAGE_USER7
        ISMRMRD_IMAGE_USER8

    cdef cppclass ImageHeader:
        uint16_t version
        uint16_t data_type
        uint64_t flags
        uint32_t measurement_uid
        uint16_t matrix_size[3]
        float field_of_view[3]
        uint16_t channels
        float position[ISMRMRD_POSITION_LENGTH]
        float read_dir[ISMRMRD_DIRECTION_LENGTH]
        float phase_dir[ISMRMRD_DIRECTION_LENGTH]
        float slice_dir[ISMRMRD_DIRECTION_LENGTH]
        float patient_table_position[ISMRMRD_POSITION_LENGTH]
        uint16_t average
        uint16_t slice
        uint16_t contrast
        uint16_t phase
        uint16_t repetition
        uint16_t set
        uint32_t acquisition_time_stamp
        uint32_t physiology_time_stamp[ISMRMRD_PHYS_STAMPS]
        uint16_t image_type
        uint16_t image_index
        uint16_t image_series_index
        int32_t user_int[ISMRMRD_USER_INTS]
        float user_float[ISMRMRD_USER_FLOATS]

    cdef cppclass Image[T]:
        Image(uint16_t, uint16_t, uint16_t, uint16_t)
        ImageHeader& getHead()
        void setHead(const ImageHeader&)
        void getAttributeString(string &atrr)
        void setAttributeString(const string attr)
        T* getData()
