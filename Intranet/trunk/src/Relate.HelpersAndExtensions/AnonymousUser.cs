namespace Relate.HelpersAndExtensions
{
    //TO FULLY IMPLEMENT A USER, THIS NEEDS TO BE REWRITTEN (OR DERIVE FROM IUser)
    public class AnonymousUser
    {
        public string Name { get; set; }
        public AnonymousUser(string name)
        {
            Name = name;
        }
    }
}
