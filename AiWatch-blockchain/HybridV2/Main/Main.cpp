#include <iostream>
#include <pybind11/embed.h>

namespace py = pybind11;

int main(){
    std::cout<<"[C++] program"<<std::endl;
    py::scoped_interpreter guard{};
    std::string jsons = {"candidate:5,data:1","candidate:2,data:2"};
    auto exampleModule = pybind11::module::import("scripts.Tracker_Module");
    auto func = exampleModule.attr("hashToLoad");
    std::string hash = func(jsons).cast<std::string>();
    //auto func2 = exampleModule.attr("sendToBlockchain");
    //func2(hash);
    auto func3 = exampleModule.attr("retriveFromBlockchain");
    std::string result = func3().cast<std::string>();
    std::cin.get();
}