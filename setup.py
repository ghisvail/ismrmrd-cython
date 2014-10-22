import os
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy

ismrmrd_home = os.environ['ISMRMRD_HOME']

extensions = [
	Extension(
		"ismrmrd",
		["ismrmrd.pyx"],
		include_dirs=[os.path.join(ismrmrd_home, 'include'),
					  numpy.get_include()],
		library_dirs=[os.path.join(ismrmrd_home, 'lib')],
		libraries=["ismrmrd"],
		extra_link_args=[]
	),
]

setup(
    name="ismrmrd",
	ext_modules = cythonize(extensions),
)
