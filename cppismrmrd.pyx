cimport cppismrmrd
from libc.stdlib cimport calloc, free
from libc.string cimport memcpy
import numpy
cimport numpy
numpy.import_array()
from cython.operator cimport dereference as deref


#### Helper functions

cdef ISMRMRDAcquisitionHeader_from_ptr(cppismrmrd.AcquisitionHeader *other):
    head = ISMRMRDAcquisitionHeader() 
    memcpy(head.thisptr, other, sizeof(cppismrmrd.AcquisitionHeader))
    return head

###

cdef class ISMRMRDEncodingCounters:
    
    cdef cppismrmrd.EncodingCounters *thisptr
    
    def __cinit__(self):
        self.thisptr = new cppismrmrd.EncodingCounters()
    
    def __dealloc__(self):
        del self.thisptr

    property kspace_encode_step_1:
        def __get__(self): return self.thisptr.kspace_encode_step_1
        def __set__(self, val): self.thisptr.kspace_encode_step_1 = val

    property kspace_encode_step_2:
        def __get__(self): return self.thisptr.kspace_encode_step_2
        def __set__(self, val): self.thisptr.kspace_encode_step_2 = val

    property average:
        def __get__(self): return self.thisptr.average
        def __set__(self, val): self.thisptr.average = val

    property slice:
        def __get__(self): return self.thisptr.slice
        def __set__(self, val): self.thisptr.slice = val

    property contrast:
        def __get__(self): return self.thisptr.contrast
        def __set__(self, val): self.thisptr.contrast = val

    property phase:
        def __get__(self): return self.thisptr.phase
        def __set__(self, val): self.thisptr.phase = val

    property repetition:
        def __get__(self): return self.thisptr.repetition
        def __set__(self, val): self.thisptr.repetition = val

    property set:
        def __get__(self): return self.thisptr.set
        def __set__(self, val): self.thisptr.set = val

    property segment:
        def __get__(self): return self.thisptr.segment
        def __set__(self, val): self.thisptr.segment = val

    property user:
        def __get__(self):
            l = [0 for i in range(cppismrmrd.ISMRMRD_USER_INTS)]
            for i in range(cppismrmrd.ISMRMRD_USER_INTS):
                l[i] = self.thisptr.user[i]
            return l
        def __set__(self, vals):
            for i in range(cppismrmrd.ISMRMRD_USER_INTS):
                self.thisptr.user[i] = vals[i]


cdef class ISMRMRDAcquisitionHeader:
    
    cdef cppismrmrd.AcquisitionHeader *thisptr
    
    def __cinit__(self):
        self.thisptr = new cppismrmrd.AcquisitionHeader()
        
    def __dealloc__(self):
        del self.thisptr

    property version:
        def __get__(self): return self.thisptr.version
        def __set__(self, val): self.thisptr.version = val

    property flags:
        def __get__(self): return self.thisptr.flags
        def __set__(self, val): self.thisptr.flags = val

    property measurement_uid:
        def __get__(self): return self.thisptr.measurement_uid
        def __set__(self, val): self.thisptr.measurement_uid = val

    property scan_counter:
        def __get__(self): return self.thisptr.scan_counter
        def __set__(self, val): self.thisptr.scan_counter = val

    property acquisition_time_stamp:
        def __get__(self): return self.thisptr.acquisition_time_stamp
        def __set__(self, val): self.thisptr.acquisition_time_stamp = val

    property physiology_time_stamp:
        def __get__(self):
            return [self.thisptr.physiology_time_stamp[i] for i in
                    range(cppismrmrd.ISMRMRD_PHYS_STAMPS)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_PHYS_STAMPS):
                self.thisptr.physiology_time_stamp[i] = val[i]

    property number_of_samples:
        def __get__(self): return self.thisptr.number_of_samples
        def __set__(self, val): self.thisptr.number_of_samples = val

    property available_channels:
        def __get__(self): return self.thisptr.available_channels
        def __set__(self, val): self.thisptr.available_channels = val

    property active_channels:
        def __get__(self): return self.thisptr.active_channels
        def __set__(self, val): self.thisptr.active_channels = val

    property channel_mask:
        def __get__(self):
            return [self.thisptr.channel_mask[i] for i in
                    range(cppismrmrd.ISMRMRD_CHANNEL_MASKS)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_CHANNEL_MASKS):
                self.thisptr.channel_mask[i] = val[i]

    property discard_pre:
        def __get__(self): return self.thisptr.discard_pre
        def __set__(self, val): self.thisptr.discard_pre = val

    property discard_post:
        def __get__(self): return self.thisptr.discard_post
        def __set__(self, val): self.thisptr.discard_post = val

    property center_sample:
        def __get__(self): return self.thisptr.center_sample
        def __set__(self, val): self.thisptr.center_sample = val

    property encoding_space_ref:
        def __get__(self): return self.thisptr.encoding_space_ref
        def __set__(self, val): self.thisptr.encoding_space_ref = val

    property trajectory_dimensions:
        def __get__(self): return self.thisptr.trajectory_dimensions
        def __set__(self, val): self.thisptr.trajectory_dimensions = val

    property sample_time_us:
        def __get__(self): return self.thisptr.sample_time_us
        def __set__(self, val): self.thisptr.sample_time_us = val

    property position:
        def __get__(self):
            return [self.thisptr.position[i] for i in
                    range(cppismrmrd.ISMRMRD_POSITION_LENGTH)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_POSITION_LENGTH):
                self.thisptr.position[i] = val[i]

    property read_dir:
        def __get__(self):
            return [self.thisptr.read_dir[i] for i in
                    range(cppismrmrd.ISMRMRD_DIRECTION_LENGTH)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_DIRECTION_LENGTH):
                self.thisptr.read_dir[i] = val[i]

    property phase_dir:
        def __get__(self):
            return [self.thisptr.phase_dir[i] for i in
                    range(cppismrmrd.ISMRMRD_DIRECTION_LENGTH)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_DIRECTION_LENGTH):
                self.thisptr.phase_dir[i] = val[i]

    property slice_dir:
        def __get__(self):
            return [self.thisptr.slice_dir[i] for i in
                    range(cppismrmrd.ISMRMRD_DIRECTION_LENGTH)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_DIRECTION_LENGTH):
                self.thisptr.slice_dir[i] = val[i]

    property patient_table_position:
        def __get__(self):
            return [self.thisptr.patient_table_position[i] for i in
                    range(cppismrmrd.ISMRMRD_POSITION_LENGTH)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_POSITION_LENGTH):
                self.thisptr.patient_table_position[i] = val[i]

    property idx:
        def __get__(self): return self.idx
        def __set__(self, ISMRMRDEncodingCounters val):
            memcpy(&self.thisptr.idx, val.thisptr,
                    sizeof(cppismrmrd.EncodingCounters))            

    property user_int:
        def __get__(self):
            return [self.thisptr.user_int[i] for i in
                    range(cppismrmrd.ISMRMRD_USER_INTS)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_USER_INTS):
                self.thisptr.user_int[i] = val[i]

    property user_float:
        def __get__(self):
            return [self.thisptr.user_float[i] for i in
                    range(cppismrmrd.ISMRMRD_USER_FLOATS)]
        def __set__(self, val):
            for i in range(cppismrmrd.ISMRMRD_USER_FLOATS):
                self.thisptr.user_float[i] = val[i]


cdef class ISMRMRDAcquisition:
    
    cdef cppismrmrd.Acquisition *thisptr
    
    def __cinit__(self):
        self.thisptr = new cppismrmrd.Acquisition()
        
    def __dealloc__(self):
        del self.thisptr

    property head:
        def __get__(self):
            return ISMRMRDAcquisitionHeader_from_ptr(<cppismrmrd.AcquisitionHeader*>&self.thisptr.getHead())
        def __set__(self, ISMRMRDAcquisitionHeader head):
            self.thisptr.setHead(<const cppismrmrd.AcquisitionHeader>deref(head.thisptr))

    property data:
        def __get__(self):
            cdef numpy.npy_intp shape_data[2]
            shape_data[0] = self.head.active_channels
            shape_data[1] = self.head.number_of_samples
            # careful here, thisptr is a R-W view
            return numpy.PyArray_SimpleNewFromData(2, shape_data,
                    numpy.NPY_COMPLEX64, <void *>(self.thisptr.getData()))

    property traj:
        def __get__(self):
            cdef numpy.npy_intp shape_traj[2]
            shape_traj[0] = self.head.number_of_samples
            shape_traj[1] = self.head.trajectory_dimensions
            # careful here, thisptr is a R-W view
            # if traj ptr is empty, then will return an empty array
            # which is arguably better than returning a NoneType.
            return numpy.PyArray_SimpleNewFromData(2, shape_traj,
                    numpy.NPY_FLOAT32, <void *>(self.thisptr.getTraj()))


cdef class ISMRMRDImageHeader:
    
    cdef cppismrmrd.ImageHeader *thisptr
    
    def __cinit__(self):
        self.thisptr = new cppismrmrd.ImageHeader()
        
    def __dealloc__(self):
        del self.thisptr


cdef class ISMRMRDImage:
    
    cdef cppismrmrd.Image[float] *thisptr
    
    def __cinit__(self, x, y, z, c):
        self.thisptr = new cppismrmrd.Image[float](x, y, z, c)
        
    def __dealloc__(self):
        del self.thisptr
