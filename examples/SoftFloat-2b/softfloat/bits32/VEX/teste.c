struct Person {
    char *name;
    int age;
    int height;
    int weight;
};

struct Person *Person_create(char *name, int age, int height, int weight)
{
    struct Person *who;
	who = (struct Person*)malloc(sizeof(struct Person));

    who->age = age;
    who->height = height;
    who->weight = weight;

    return who;
}
