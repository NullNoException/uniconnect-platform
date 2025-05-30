using AutoMapper;
using UniConnect.Application.AcademicCalendars.DTOs;
using UniConnect.Domain.Entities;

namespace UniConnect.Application.AcademicCalendars.Mappings;

public class AcademicCalendarMappingProfile : Profile
{
    public AcademicCalendarMappingProfile()
    {
        // AcademicCalendar -> AcademicCalendarDto
        CreateMap<AcademicCalendar, AcademicCalendarDto>()
            .ForMember(dest => dest.UniversityName, opt => opt.MapFrom(src => src.University != null ? src.University.Name : string.Empty));

        // AcademicYear -> AcademicYearDto
        CreateMap<AcademicYear, AcademicYearDto>()
            .ForMember(dest => dest.AcademicCalendarName, opt => opt.MapFrom(src => src.AcademicCalendar != null ? src.AcademicCalendar.Name : string.Empty));

        // Semester -> SemesterDto
        CreateMap<Semester, SemesterDto>()
            .ForMember(dest => dest.AcademicYearName, opt => opt.MapFrom(src => src.AcademicYear != null ? src.AcademicYear.Name : string.Empty))
            .ForMember(dest => dest.Deadlines, opt => opt.MapFrom(src => src.Deadlines));

        // Deadline -> DeadlineDto
        CreateMap<Deadline, DeadlineDto>()
            .ForMember(dest => dest.SemesterName, opt => opt.MapFrom(src => src.Semester != null ? src.Semester.Name : string.Empty));

        // SemesterProgram -> SemesterProgramDto
        CreateMap<SemesterProgram, SemesterProgramDto>()
            .ForMember(dest => dest.SemesterName, opt => opt.MapFrom(src => src.Semester != null ? src.Semester.Name : string.Empty))
            .ForMember(dest => dest.ProgramName, opt => opt.MapFrom(src => src.Program != null ? src.Program.Name : string.Empty))
            .ForMember(dest => dest.ProgramCode, opt => opt.MapFrom(src => src.Program != null ? src.Program.ProgramCode : string.Empty))
            .ForMember(dest => dest.AcademicLevelName, opt => opt.MapFrom(src => src.Program != null && src.Program.AcademicLevel != null ? src.Program.AcademicLevel.Name : string.Empty))
            .ForMember(dest => dest.MajorName, opt => opt.MapFrom(src => src.Program != null && src.Program.Major != null ? src.Program.Major.Name : null))
            .ForMember(dest => dest.TuitionFee, opt => opt.MapFrom(src => src.Program != null ? src.Program.BaseTuitionFee : null))
            .ForMember(dest => dest.CurrencyCode, opt => opt.MapFrom(src => src.Program != null && src.Program.Currency != null ? src.Program.Currency.CurrencyCode : null));
    }
}
