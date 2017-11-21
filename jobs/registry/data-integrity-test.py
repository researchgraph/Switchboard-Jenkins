import sys
from py2neo import Graph

valid_labels = ['researcher', 'dataset', 'publication', 'grant', 'axillary', 'nci']
valid_types = ['researcher', 'dataset', 'publication', 'grant', 'axillary']


def main(source_label):
    error_count = 0
    print "Source Label: '%s' " % source_label

    graph = Graph()

    # Check if all nodes have valid Type Label
    query = 'match (n) where labels(n)=[] return count(n)'
    result = graph.run(query).evaluate()
    if result > 0:
        error_count += 1
        print ("Error %d: %d nodes have no label." % (error_count, result))
        sys.exit(-1)

    # Check if all nodes have valid Type Label
    query = 'MATCH (n) where NOT n:researcher and NOT n:publication and NOT n:dataset and NOT n:grant RETURN count(n)'
    result = graph.run(query).evaluate()
    if result > 0:
        error_count += 1
        print ("Error %d: %d nodes are missing at least one Valid Type Label "
               "('researcher', 'dataset', 'publication', 'grant')" % (error_count, result))

    # Check of if all labels are valid
    query = 'MATCH (n) RETURN distinct(labels(n)) as Labels'
    cursor = graph.run(query)
    while cursor.forward():
        labels = cursor.current()['Labels']
        for l in labels:
            if l not in valid_labels:
                    error_count += 1
                    print "Error %d: '%s' is an invalid Label in this graph cluster" % (error_count,l)

    # Check if all nodes have valid 'type' value
    query = "MATCH (n) where NOT (n.type in %s) RETURN count(n)" % valid_types
    result = graph.run(query).evaluate()
    if result > 0:
        error_count += 1
        print ("Error %d: %d nodes are missing at least one valid n.type value "
               "('researcher', 'dataset', 'publication', 'grant')" % (error_count, result))

    if error_count > 0:
        sys.exit(-1)


if __name__ == "__main__":
    main(sys.argv[1])


