namespace Dot.Console
{
    public interface IApplicationOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
