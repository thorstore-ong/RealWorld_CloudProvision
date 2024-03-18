from setuptools import setup, find_packages

setup(
    name='RealWorld-Package',
    version='0.1',
    packages=find_packages(),
    include_package_data=True,
    license='MIT License',  
    description='A demo project on installing an application into huawei cloud',
    long_description=open('README.md').read(),
    url='https://github.com/danjac/realworld',
    author='Thoriso Mokhethi',
    author_email='thoriso.mokhethi@mpilo.africa',
    classifiers=[
        'Environment :: Web Environment',
        'Framework :: Django',
    ],
    install_requires=[
        'Django>=3.1',  
    ],
)


