"""
Example of how multiprocessing can be implemented. Used to use this a lot, but it's also not terribly difficult to
implement directly.
"""

def simple_multiprocess(funct, input_list, to_multiprocess=True):
    """
        I use this a lot. Make it a simple function to clean up code in a few places
        Args:
            funct: Function to use in multiprocessing
            input_list: list of list to pass to processing function. Basically, pack all arguments into a list and have
            function unpack the list. Example: [[arg1, arg2, arg3], [arg1, arg2, arg3], .... ]
            to_multiprocess: set to False to process one at a time - for testing

        Returns: List of ouputs from the function that was called
    """
    if to_multiprocess:
        logging.debug("Creating {} threads to multiprocess".format(len(input_list)))
        cpu_num = cpu_count()
        p = Pool(processes=cpu_num)
        # starmap is SO GOOD.
        output_list = p.starmap(funct, input_list)

    else:
        # This would mainly be for debugging
        logging.debug("Processing inputs one at a time in multiprocess function")
        output_list = []
        for list_item in input_list:
            output_list.append(funct(list_item))

    return output_list
