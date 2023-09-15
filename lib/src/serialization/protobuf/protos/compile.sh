rm -rf ../models
mkdir ../models
protoc -I=. --dart_out=../models ./*.proto google/protobuf/any.proto