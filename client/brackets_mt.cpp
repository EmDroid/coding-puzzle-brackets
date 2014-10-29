/**
    @file

    Brackets coding puzzle - Part 2 (multi threaded processing).

    @author Emil Maskovsky
*/

// standard library
#include <cstdlib>
#include <iostream>

// Boost
#include <boost/exception/diagnostic_information.hpp>

// BracketPuzzle
#include "BracketPuzzle/MultithreadProcessor.hpp"
#include "BracketPuzzle/StandardValidator.hpp"
#include "BracketPuzzle/StreamInputReader.hpp"
#include "BracketPuzzle/StreamResultWriter.hpp"


int main()
{
    using namespace BracketPuzzle;

    int result = EXIT_SUCCESS;

    try
    {
        StandardValidator validator;
        StreamInputReader reader(std::cin);
        StreamResultWriter writer(std::cout);

        MultithreadProcessor processor;
        if (!processor.execute(validator, reader, writer))
        {
            result = EXIT_FAILURE;
        }
    }
    catch (const boost::exception & e)
    {
        std::cerr << boost::diagnostic_information(e) << std::endl;
        result = EXIT_FAILURE;
    }
    catch (const std::exception & e)
    {
        std::cerr << std::endl
                  << "FAILURE: Exception caught!" << std::endl
                  << "Message: " << e.what() << std::endl;
        result = EXIT_FAILURE;
    }
    catch (...)
    {
        std::cerr << std::endl
                  << "FAILURE: Unknown exception caught!" << std::endl;
        result = EXIT_FAILURE;
    }

    return result;
}


/* EOF */