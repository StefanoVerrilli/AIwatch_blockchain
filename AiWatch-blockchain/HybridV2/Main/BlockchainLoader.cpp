#include <iostream>
#include <pybind11/embed.h>


std::string getHash(std::string Json){
    pybind11::scoped_interpreter guard{};
    auto HashingModule = pybind11::module::import("scripts.Hashing");
    auto func = HashingModule.attr("hashToLoad");
    return func(jsons).cast<std::string>();
} 


void LoadToBlockchain(std::string Hash){
    pybind11::scoped_interpreter guard{};
    auto Blockchain = pybind11::module::import("scripts.Tracker_Module");
    auto func = Blockchain.attr("sendToBlockchain");
    func(Hash);
}
