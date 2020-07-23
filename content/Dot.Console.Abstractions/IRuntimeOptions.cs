namespace _NameSpace_
{
    public interface IRunOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
