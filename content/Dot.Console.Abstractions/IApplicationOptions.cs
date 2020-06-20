namespace _NameSpace_
{
    public interface IApplicationOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
