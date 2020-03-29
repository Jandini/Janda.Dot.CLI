namespace Dot.Console
{
    public interface IProgramOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
