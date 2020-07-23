namespace _NameSpace_
{
    public interface IRuntimeOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
