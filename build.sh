#!/bin/bash

rm -rf pkg/*gem
rbenv exec rake build
rbenv rehash
