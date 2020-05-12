namespace Dot.Console.Abstractions
{
    public interface IApplicationOptions
    {
#if (addArgs)
        bool Verbose { get; }  
#endif
    }
}
